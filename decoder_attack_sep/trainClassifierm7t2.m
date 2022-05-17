function [trainedClassifier, validationAccuracy] = trainClassifierm7t2(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% 훈련된 분류기와 그 정확도을(를) 반환합니다. 이 코드는 분류 학습기 앱에서 훈련된 분류
% 모델을 다시 만듭니다. 생성된 코드를 사용하여 동일한 모델을 새 데이터로 훈련시키는 것을
% 자동화하거나, 모델을 프로그래밍 방식으로 훈련시키는 방법을 익힐 수 있습니다.
%
%  입력값:
%      trainingData: 앱으로 가져온 행렬과 동일한 개수의 열과 데이터형을 갖는 행렬입니
%       다.
%
%  출력값:
%      trainedClassifier: 훈련된 분류기가 포함된 구조체입니다. 이 구조체에는 훈련된
%       분류기에 대한 정보가 포함된 다양한 필드가 들어 있습니다.
%
%      trainedClassifier.predictFcn: 새 데이터를 사용하여 예측하기 위한 함수입니
%       다.
%
%      validationAccuracy: 정확도(%)를 포함하는 double형입니다. 이 전반적인 정확도
%       점수는 앱의 내역 목록에 각 모델별로 표시됩니다.
%
% 새 데이터로 모델을 훈련시키려면 이 코드를 사용하십시오. 분류기를 다시 훈련시키려면 명령
% 줄에서 원래 데이터나 새 데이터를 입력 인수 trainingData(으)로 사용하여 함수를 호출하
% 십시오.
%
% 예를 들어, 원래 데이터 세트 T(으)로 훈련된 분류기를 다시 훈련시키려면 다음을 입력하십
% 시오.
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% 새 데이터 T2에서 반환된 'trainedClassifier'을(를) 사용하여 예측하려면 다음을 사용
% 하십시오.
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2은(는) 훈련에 사용된 예측 변수 열만 포함하는 행렬이어야 합니다. 세부 정보를 보려면
% 다음을 입력하십시오.
%   trainedClassifier.HowToPredict

% MATLAB에서 2022-05-13 15:07:24에 자동 생성됨


% 예측 변수와 응답 변수 추출
% 이 코드는 모델을 훈련시키기에 적합한 형태로 데이터를
% 처리합니다.
% 입력값을 테이블로 변환
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14', 'column_15', 'column_16', 'column_17', 'column_18', 'column_19', 'column_20', 'column_21', 'column_22', 'column_23', 'column_24', 'column_25', 'column_26', 'column_27', 'column_28', 'column_29', 'column_30', 'column_31', 'column_32', 'column_33', 'column_34', 'column_35', 'column_36', 'column_37', 'column_38', 'column_39', 'column_40', 'column_41', 'column_42', 'column_43', 'column_44', 'column_45', 'column_46', 'column_47', 'column_48', 'column_49', 'column_50', 'column_51', 'column_52', 'column_53', 'column_54', 'column_55', 'column_56', 'column_57', 'column_58', 'column_59', 'column_60', 'column_61', 'column_62', 'column_63', 'column_64', 'column_65', 'column_66', 'column_67', 'column_68', 'column_69', 'column_70', 'column_71', 'column_72', 'column_73', 'column_74', 'column_75', 'column_76', 'column_77', 'column_78', 'column_79', 'column_80', 'column_81', 'column_82', 'column_83', 'column_84', 'column_85', 'column_86', 'column_87', 'column_88', 'column_89', 'column_90', 'column_91', 'column_92', 'column_93', 'column_94', 'column_95', 'column_96', 'column_97', 'column_98', 'column_99', 'column_100', 'column_101', 'column_102', 'column_103', 'column_104', 'column_105', 'column_106', 'column_107', 'column_108', 'column_109', 'column_110', 'column_111', 'column_112', 'column_113', 'column_114', 'column_115', 'column_116', 'column_117', 'column_118', 'column_119', 'column_120', 'column_121', 'column_122', 'column_123', 'column_124', 'column_125', 'column_126', 'column_127', 'column_128', 'column_129', 'column_130', 'column_131', 'column_132', 'column_133', 'column_134', 'column_135', 'column_136', 'column_137', 'column_138', 'column_139', 'column_140', 'column_141', 'column_142', 'column_143', 'column_144', 'column_145', 'column_146', 'column_147', 'column_148', 'column_149', 'column_150', 'column_151', 'column_152', 'column_153', 'column_154', 'column_155', 'column_156', 'column_157', 'column_158', 'column_159', 'column_160', 'column_161', 'column_162', 'column_163', 'column_164', 'column_165', 'column_166', 'column_167', 'column_168', 'column_169', 'column_170', 'column_171', 'column_172', 'column_173', 'column_174', 'column_175', 'column_176', 'column_177', 'column_178', 'column_179', 'column_180', 'column_181', 'column_182', 'column_183', 'column_184', 'column_185', 'column_186', 'column_187', 'column_188', 'column_189', 'column_190', 'column_191', 'column_192', 'column_193', 'column_194', 'column_195', 'column_196', 'column_197', 'column_198', 'column_199', 'column_200', 'column_201', 'column_202', 'column_203', 'column_204', 'column_205', 'column_206', 'column_207', 'column_208', 'column_209', 'column_210', 'column_211', 'column_212', 'column_213', 'column_214', 'column_215', 'column_216', 'column_217', 'column_218', 'column_219', 'column_220', 'column_221', 'column_222', 'column_223', 'column_224', 'column_225', 'column_226', 'column_227', 'column_228', 'column_229', 'column_230', 'column_231'});

predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14', 'column_15', 'column_16', 'column_17', 'column_18', 'column_19', 'column_20', 'column_21', 'column_22', 'column_23', 'column_24', 'column_25', 'column_26', 'column_27', 'column_28', 'column_29', 'column_30', 'column_31', 'column_32', 'column_33', 'column_34', 'column_35', 'column_36', 'column_37', 'column_38', 'column_39', 'column_40', 'column_41', 'column_42', 'column_43', 'column_44', 'column_45', 'column_46', 'column_47', 'column_48', 'column_49', 'column_50', 'column_51', 'column_52', 'column_53', 'column_54', 'column_55', 'column_56', 'column_57', 'column_58', 'column_59', 'column_60', 'column_61', 'column_62', 'column_63', 'column_64', 'column_65', 'column_66', 'column_67', 'column_68', 'column_69', 'column_70', 'column_71', 'column_72', 'column_73', 'column_74', 'column_75', 'column_76', 'column_77', 'column_78', 'column_79', 'column_80', 'column_81', 'column_82', 'column_83', 'column_84', 'column_85', 'column_86', 'column_87', 'column_88', 'column_89', 'column_90', 'column_91', 'column_92', 'column_93', 'column_94', 'column_95', 'column_96', 'column_97', 'column_98', 'column_99', 'column_100', 'column_101', 'column_102', 'column_103', 'column_104', 'column_105', 'column_106', 'column_107', 'column_108', 'column_109', 'column_110', 'column_111', 'column_112', 'column_113', 'column_114', 'column_115', 'column_116', 'column_117', 'column_118', 'column_119', 'column_120', 'column_121', 'column_122', 'column_123', 'column_124', 'column_125', 'column_126', 'column_127', 'column_128', 'column_129', 'column_130', 'column_131', 'column_132', 'column_133', 'column_134', 'column_135', 'column_136', 'column_137', 'column_138', 'column_139', 'column_140', 'column_141', 'column_142', 'column_143', 'column_144', 'column_145', 'column_146', 'column_147', 'column_148', 'column_149', 'column_150', 'column_151', 'column_152', 'column_153', 'column_154', 'column_155', 'column_156', 'column_157', 'column_158', 'column_159', 'column_160', 'column_161', 'column_162', 'column_163', 'column_164', 'column_165', 'column_166', 'column_167', 'column_168', 'column_169', 'column_170', 'column_171', 'column_172', 'column_173', 'column_174', 'column_175', 'column_176', 'column_177', 'column_178', 'column_179', 'column_180', 'column_181', 'column_182', 'column_183', 'column_184', 'column_185', 'column_186', 'column_187', 'column_188', 'column_189', 'column_190', 'column_191', 'column_192', 'column_193', 'column_194', 'column_195', 'column_196', 'column_197', 'column_198', 'column_199', 'column_200', 'column_201', 'column_202', 'column_203', 'column_204', 'column_205', 'column_206', 'column_207', 'column_208', 'column_209', 'column_210', 'column_211', 'column_212', 'column_213', 'column_214', 'column_215', 'column_216', 'column_217', 'column_218', 'column_219', 'column_220', 'column_221', 'column_222', 'column_223', 'column_224', 'column_225', 'column_226', 'column_227', 'column_228', 'column_229', 'column_230'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_231;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% 예측 변수 행렬에 PCA를 적용합니다.
% 숫자형 예측 변수에 대해서만 PCA를 실행합니다. categorical형 예측 변수는 PCA를 거쳐도 전혀 변경되지 않습니다.
isCategoricalPredictorBeforePCA = isCategoricalPredictor;
numericPredictors = predictors(:, ~isCategoricalPredictor);
numericPredictors = table2array(varfun(@double, numericPredictors));
% PCA의 경우 'inf' 값은 누락된 데이터로 처리되어야 합니다.
numericPredictors(isinf(numericPredictors)) = NaN;
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(...
    numericPredictors);
% 원하는 크기의 분산을 설명하기에 충분한 성분 개수를 유지합니다.
explainedVarianceToKeepAsFraction = 95/100;
numComponentsToKeep = find(cumsum(explained)/sum(explained) >= explainedVarianceToKeepAsFraction, 1);
pcaCoefficients = pcaCoefficients(:,1:numComponentsToKeep);
predictors = [array2table(pcaScores(:,1:numComponentsToKeep)), predictors(:, isCategoricalPredictor)];
isCategoricalPredictor = [false(1,numComponentsToKeep), true(1,sum(isCategoricalPredictor))];

% 분류기 훈련
% 이 코드는 모든 분류기 옵션을 지정하고 분류기를 훈련시킵니다.
template = templateSVM(...
    'KernelFunction', 'gaussian', ...
    'PolynomialOrder', [], ...
    'KernelScale', 196.1052215998229, ...
    'BoxConstraint', 2.631147377970418, ...
    'Standardize', false);
classificationSVM = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsall', ...
    'ClassNames', [0; 1; 2; 3; 4; 5; 6]);

% 예측 함수를 사용하여 결과 구조체 생성
predictorExtractionFcn = @(x) array2table(x, 'VariableNames', predictorNames);
pcaTransformationFcn = @(x) [ array2table((table2array(varfun(@double, x(:, ~isCategoricalPredictorBeforePCA))) - pcaCenters) * pcaCoefficients), x(:,isCategoricalPredictorBeforePCA) ];
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(pcaTransformationFcn(predictorExtractionFcn(x)));

% 추가적인 필드를 결과 구조체에 추가
trainedClassifier.PCACenters = pcaCenters;
trainedClassifier.PCACoefficients = pcaCoefficients;
trainedClassifier.ClassificationSVM = classificationSVM;
trainedClassifier.About = '이 구조체는 분류 학습기 R2020a에서 내보낸 훈련된 모델입니다.';
trainedClassifier.HowToPredict = sprintf('새 예측 변수 열 행렬 X를 사용하여 예측하려면 다음을 사용하십시오. \n yfit = c.predictFcn(X) \n여기서 ''c''를 이 구조체를 나타내는 변수의 이름(예: ''trainedModel'')으로 바꾸십시오. \n \n이 모델은 230개의 예측 변수를 사용하여 훈련되었으므로 X는 정확히 230개의 열을 포함해야 합니다. \nX는 훈련 데이터와 정확히 동일한 순서와 형식의 예측 변수 열만 포함해야 \n합니다. 응답 변수 열이나 앱으로 가져오지 않은 열은 포함시키지 마십시오. \n \n자세한 내용은 <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>을(를) 참조하십시오.');

% 예측 변수와 응답 변수 추출
% 이 코드는 모델을 훈련시키기에 적합한 형태로 데이터를
% 처리합니다.
% 입력값을 테이블로 변환
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14', 'column_15', 'column_16', 'column_17', 'column_18', 'column_19', 'column_20', 'column_21', 'column_22', 'column_23', 'column_24', 'column_25', 'column_26', 'column_27', 'column_28', 'column_29', 'column_30', 'column_31', 'column_32', 'column_33', 'column_34', 'column_35', 'column_36', 'column_37', 'column_38', 'column_39', 'column_40', 'column_41', 'column_42', 'column_43', 'column_44', 'column_45', 'column_46', 'column_47', 'column_48', 'column_49', 'column_50', 'column_51', 'column_52', 'column_53', 'column_54', 'column_55', 'column_56', 'column_57', 'column_58', 'column_59', 'column_60', 'column_61', 'column_62', 'column_63', 'column_64', 'column_65', 'column_66', 'column_67', 'column_68', 'column_69', 'column_70', 'column_71', 'column_72', 'column_73', 'column_74', 'column_75', 'column_76', 'column_77', 'column_78', 'column_79', 'column_80', 'column_81', 'column_82', 'column_83', 'column_84', 'column_85', 'column_86', 'column_87', 'column_88', 'column_89', 'column_90', 'column_91', 'column_92', 'column_93', 'column_94', 'column_95', 'column_96', 'column_97', 'column_98', 'column_99', 'column_100', 'column_101', 'column_102', 'column_103', 'column_104', 'column_105', 'column_106', 'column_107', 'column_108', 'column_109', 'column_110', 'column_111', 'column_112', 'column_113', 'column_114', 'column_115', 'column_116', 'column_117', 'column_118', 'column_119', 'column_120', 'column_121', 'column_122', 'column_123', 'column_124', 'column_125', 'column_126', 'column_127', 'column_128', 'column_129', 'column_130', 'column_131', 'column_132', 'column_133', 'column_134', 'column_135', 'column_136', 'column_137', 'column_138', 'column_139', 'column_140', 'column_141', 'column_142', 'column_143', 'column_144', 'column_145', 'column_146', 'column_147', 'column_148', 'column_149', 'column_150', 'column_151', 'column_152', 'column_153', 'column_154', 'column_155', 'column_156', 'column_157', 'column_158', 'column_159', 'column_160', 'column_161', 'column_162', 'column_163', 'column_164', 'column_165', 'column_166', 'column_167', 'column_168', 'column_169', 'column_170', 'column_171', 'column_172', 'column_173', 'column_174', 'column_175', 'column_176', 'column_177', 'column_178', 'column_179', 'column_180', 'column_181', 'column_182', 'column_183', 'column_184', 'column_185', 'column_186', 'column_187', 'column_188', 'column_189', 'column_190', 'column_191', 'column_192', 'column_193', 'column_194', 'column_195', 'column_196', 'column_197', 'column_198', 'column_199', 'column_200', 'column_201', 'column_202', 'column_203', 'column_204', 'column_205', 'column_206', 'column_207', 'column_208', 'column_209', 'column_210', 'column_211', 'column_212', 'column_213', 'column_214', 'column_215', 'column_216', 'column_217', 'column_218', 'column_219', 'column_220', 'column_221', 'column_222', 'column_223', 'column_224', 'column_225', 'column_226', 'column_227', 'column_228', 'column_229', 'column_230', 'column_231'});

predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14', 'column_15', 'column_16', 'column_17', 'column_18', 'column_19', 'column_20', 'column_21', 'column_22', 'column_23', 'column_24', 'column_25', 'column_26', 'column_27', 'column_28', 'column_29', 'column_30', 'column_31', 'column_32', 'column_33', 'column_34', 'column_35', 'column_36', 'column_37', 'column_38', 'column_39', 'column_40', 'column_41', 'column_42', 'column_43', 'column_44', 'column_45', 'column_46', 'column_47', 'column_48', 'column_49', 'column_50', 'column_51', 'column_52', 'column_53', 'column_54', 'column_55', 'column_56', 'column_57', 'column_58', 'column_59', 'column_60', 'column_61', 'column_62', 'column_63', 'column_64', 'column_65', 'column_66', 'column_67', 'column_68', 'column_69', 'column_70', 'column_71', 'column_72', 'column_73', 'column_74', 'column_75', 'column_76', 'column_77', 'column_78', 'column_79', 'column_80', 'column_81', 'column_82', 'column_83', 'column_84', 'column_85', 'column_86', 'column_87', 'column_88', 'column_89', 'column_90', 'column_91', 'column_92', 'column_93', 'column_94', 'column_95', 'column_96', 'column_97', 'column_98', 'column_99', 'column_100', 'column_101', 'column_102', 'column_103', 'column_104', 'column_105', 'column_106', 'column_107', 'column_108', 'column_109', 'column_110', 'column_111', 'column_112', 'column_113', 'column_114', 'column_115', 'column_116', 'column_117', 'column_118', 'column_119', 'column_120', 'column_121', 'column_122', 'column_123', 'column_124', 'column_125', 'column_126', 'column_127', 'column_128', 'column_129', 'column_130', 'column_131', 'column_132', 'column_133', 'column_134', 'column_135', 'column_136', 'column_137', 'column_138', 'column_139', 'column_140', 'column_141', 'column_142', 'column_143', 'column_144', 'column_145', 'column_146', 'column_147', 'column_148', 'column_149', 'column_150', 'column_151', 'column_152', 'column_153', 'column_154', 'column_155', 'column_156', 'column_157', 'column_158', 'column_159', 'column_160', 'column_161', 'column_162', 'column_163', 'column_164', 'column_165', 'column_166', 'column_167', 'column_168', 'column_169', 'column_170', 'column_171', 'column_172', 'column_173', 'column_174', 'column_175', 'column_176', 'column_177', 'column_178', 'column_179', 'column_180', 'column_181', 'column_182', 'column_183', 'column_184', 'column_185', 'column_186', 'column_187', 'column_188', 'column_189', 'column_190', 'column_191', 'column_192', 'column_193', 'column_194', 'column_195', 'column_196', 'column_197', 'column_198', 'column_199', 'column_200', 'column_201', 'column_202', 'column_203', 'column_204', 'column_205', 'column_206', 'column_207', 'column_208', 'column_209', 'column_210', 'column_211', 'column_212', 'column_213', 'column_214', 'column_215', 'column_216', 'column_217', 'column_218', 'column_219', 'column_220', 'column_221', 'column_222', 'column_223', 'column_224', 'column_225', 'column_226', 'column_227', 'column_228', 'column_229', 'column_230'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_231;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% 교차 검증 수행
KFolds = 10;
cvp = cvpartition(response, 'KFold', KFolds);
% 예측값을 적절한 크기로 초기화
validationPredictions = response;
numObservations = size(predictors, 1);
numClasses = 7;
validationScores = NaN(numObservations, numClasses);
for fold = 1:KFolds
    trainingPredictors = predictors(cvp.training(fold), :);
    trainingResponse = response(cvp.training(fold), :);
    foldIsCategoricalPredictor = isCategoricalPredictor;
    
    % 예측 변수 행렬에 PCA를 적용합니다.
    % 숫자형 예측 변수에 대해서만 PCA를 실행합니다. categorical형 예측 변수는 PCA를 거쳐도 전혀 변경되지 않습니다.
    isCategoricalPredictorBeforePCA = foldIsCategoricalPredictor;
    numericPredictors = trainingPredictors(:, ~foldIsCategoricalPredictor);
    numericPredictors = table2array(varfun(@double, numericPredictors));
    % PCA의 경우 'inf' 값은 누락된 데이터로 처리되어야 합니다.
    numericPredictors(isinf(numericPredictors)) = NaN;
    [pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(...
        numericPredictors);
    % 원하는 크기의 분산을 설명하기에 충분한 성분 개수를 유지합니다.
    explainedVarianceToKeepAsFraction = 95/100;
    numComponentsToKeep = find(cumsum(explained)/sum(explained) >= explainedVarianceToKeepAsFraction, 1);
    pcaCoefficients = pcaCoefficients(:,1:numComponentsToKeep);
    trainingPredictors = [array2table(pcaScores(:,1:numComponentsToKeep)), trainingPredictors(:, foldIsCategoricalPredictor)];
    foldIsCategoricalPredictor = [false(1,numComponentsToKeep), true(1,sum(foldIsCategoricalPredictor))];
    
    % 분류기 훈련
    % 이 코드는 모든 분류기 옵션을 지정하고 분류기를 훈련시킵니다.
    template = templateSVM(...
        'KernelFunction', 'gaussian', ...
        'PolynomialOrder', [], ...
        'KernelScale', 196.1052215998229, ...
        'BoxConstraint', 2.631147377970418, ...
        'Standardize', false);
    classificationSVM = fitcecoc(...
        trainingPredictors, ...
        trainingResponse, ...
        'Learners', template, ...
        'Coding', 'onevsall', ...
        'ClassNames', [0; 1; 2; 3; 4; 5; 6]);
    
    % 예측 함수를 사용하여 결과 구조체 생성
    pcaTransformationFcn = @(x) [ array2table((table2array(varfun(@double, x(:, ~isCategoricalPredictorBeforePCA))) - pcaCenters) * pcaCoefficients), x(:,isCategoricalPredictorBeforePCA) ];
    svmPredictFcn = @(x) predict(classificationSVM, x);
    validationPredictFcn = @(x) svmPredictFcn(pcaTransformationFcn(x));
    
    % 추가적인 필드를 결과 구조체에 추가
    
    % 검증 예측값 계산
    validationPredictors = predictors(cvp.test(fold), :);
    [foldPredictions, foldScores] = validationPredictFcn(validationPredictors);
    
    % 예측값을 원래 순서대로 저장
    validationPredictions(cvp.test(fold), :) = foldPredictions;
    validationScores(cvp.test(fold), :) = foldScores;
end

% 검증 정확도 계산
correctPredictions = (validationPredictions == response);
isMissing = isnan(response);
correctPredictions = correctPredictions(~isMissing);
validationAccuracy = sum(correctPredictions)/length(correctPredictions);
